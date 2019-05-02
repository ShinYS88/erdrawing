package kr.or.ddit.util;

import static org.junit.Assert.*;

import org.junit.Test;

import kr.or.ddit.util.encrypt.kisa.sha256.KISA_SHA256;

public class KISA_SHA256Test {

	@Test
	public void testPassword() {
		
		assertEquals("3ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4", KISA_SHA256.encrypt("1234"));
		assertNotEquals("1111", KISA_SHA256.encrypt("1234"));
	}

}
